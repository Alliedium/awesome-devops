#   Copyright (C) Allied Testing Ltd. - All Rights Reserved
#   Unauthorized copying of this file, via any medium is strictly prohibited
#   Penalties for copyright infringement include civil and criminal penalties
#   Proprietary and confidential

import subprocess
import argparse
from pathlib import Path
import os
import sys
import logging
import tempfile
from typing import List, Dict, Callable, Any

LOG_LEVEL: str = "INFO"
MAX_LINE_LENGTH: int = 88
LOGGING_FORMAT: str = (
        "\n"
        + "-" * MAX_LINE_LENGTH
        + "\n%(asctime)s - %(name)s - %(levelname)s: %(message)s\n"
        + "-" * MAX_LINE_LENGTH
        + "\n"
)
logging.basicConfig(format=LOGGING_FORMAT, level=LOG_LEVEL)
IS_WINDOWS: bool = os.name == 'nt'


def exec_cmd(command) -> None:
    if not IS_WINDOWS:
        command: str = ' '.join(command)

    try:
        cmd_exec_str: str = f'executing command "{command}"'
        logging.info(cmd_exec_str + "...")
        exec_code = subprocess.call(command, shell=True)
        if exec_code == 0:
            logging.info(cmd_exec_str + ": SUCCESS")
        else:
            logging.fatal(f"command failed, exiting with code {exec_code}")
            sys.exit(exec_code)
    except KeyboardInterrupt:
        logging.fatal(f"Execution has been interrupted")
        sys.exit()
    except Exception as e:
        logging.fatal(f"Command has failed with the following exception: {e}")
        raise e


CURRENT_CONDA_ENV_PATH: str = os.environ["CONDA_PREFIX"]

CURRENT_PATH: Path = Path(__file__).absolute().parent

MAIN_CMD_NAME: str = __file__


def get_prog_name() -> str:
    return MAIN_CMD_NAME + " " + sys.argv[1]


def install_conda_env_from_relfile(conda_env_path: str, req_abspath: Path, debug: bool = False) -> None:
    micromamba_command_envinstall_list: List[str] = \
        ["micromamba", "install", "--ssl-verify", "false", "-y", "--debug" if debug else "", "-p", conda_env_path, "-f"] + [
        str(req_abspath)
    ]

    exec_cmd(micromamba_command_envinstall_list)


def filter_python_requirements_by_mode(req_relpath: Path, mode: str) -> Path:
    out_stream: tempfile.NamedTemporaryFile = tempfile.NamedTemporaryFile('wt', suffix='.yml', delete=False)
    with open(str(CURRENT_PATH / req_relpath), 'rt') as inp_stream:
        inp_line_str: str = inp_stream.readline()
        if mode == "all":
            while inp_line_str:
                out_stream.write(inp_line_str)
                inp_line_str = inp_stream.readline()
        else:
            is_pip: bool = False
            inp_pip_line_str: str = None
            prev_out_line_str: str = None
            while inp_line_str:
                if not is_pip:
                    is_pip = '- pip:' in inp_line_str
                    if is_pip:
                        inp_pip_line_str = inp_line_str.rstrip()
                        inp_line_str = inp_stream.readline()
                        if not inp_line_str:
                            out_stream.write(prev_out_line_str)
                        continue
                ind_comment_start: int = inp_line_str.find('#')
                if ind_comment_start >= 0:
                    mode_list: List[str] = \
                        [mode_str.strip() for mode_str in inp_line_str[ind_comment_start + 1:].rstrip().split(',')]
                    if mode not in mode_list:
                        inp_line_str = inp_stream.readline()
                        if not inp_line_str:
                            out_stream.write(prev_out_line_str)
                        continue
                    out_line_str = inp_line_str[:ind_comment_start]
                else:
                    out_line_str = inp_line_str.rstrip()
                inp_line_str = inp_stream.readline()
                if prev_out_line_str is not None:
                    out_stream.write(prev_out_line_str + '\n')
                if is_pip:
                    out_stream.write(inp_pip_line_str + '\n')
                    is_pip = False
                if inp_line_str:
                    prev_out_line_str = out_line_str
                else:
                    out_stream.write(out_line_str)
    out_stream.close()
    return Path(out_stream.name)


def install(conda_env_path: str, mode: str, debug: bool=False):
    __MODE2CMD_DICT: Dict[str, Dict[str, Any]] = {
        "packages": {
            "install_requirements": True,
            "filter_requirements": False,
        },
    }
    if mode in __MODE2CMD_DICT:
        cmd_run_param_dict: Dict[str, Any] = __MODE2CMD_DICT[mode]
    else:
        cmd_run_param_dict: Dict[str, Any] = {
            "install_requirements": True,
            "filter_requirements": True,
        }

    if cmd_run_param_dict["install_requirements"]:
        python_requirements_abs_path: Path = \
            filter_python_requirements_by_mode(
                Path("python_requirements.yml"),
                mode if cmd_run_param_dict["filter_requirements"] else "all")
        install_conda_env_from_relfile(conda_env_path, python_requirements_abs_path, debug)
        os.unlink(str(python_requirements_abs_path))


def install_cli():
    arg_parser: argparse.ArgumentParser = argparse.ArgumentParser(
        prog=MAIN_CMD_NAME,
        formatter_class=argparse.RawTextHelpFormatter,
        description="Python Environment Installer",
    )

    arg_parser.add_argument(
        "mode",
        help="What to install" 'run with "-h" argument e.g.\n'
        f"{MAIN_CMD_NAME} install packages\n"
        f"{MAIN_CMD_NAME} install @@@@@@\n"
        "Here the last choice is almost the same as install packages\n"
        "save that necessary packages are filtered from python_requirements.yml file as follows,\n"
        "@@@@@ stands for some mode by which filtration of dependencies is performed,\n"
        "namely a dependency having an inline comment is selected only in the case\n"
        "this inline comment includes the mentioned mode in the comma-separated list of modes,\n"
        "all other dependencies not having inline comments are always included\n",
    )

    arg_parser.add_argument(
        "-d",
        "--debug",
        action="store_true",
        help="install with debug logs",
    )

    install_args: argparse.Namespace = arg_parser.parse_args(args=sys.argv[2:])

    install(CURRENT_CONDA_ENV_PATH, install_args.mode, install_args.debug)


if __name__ == "__main__":
    argument_parser = argparse.ArgumentParser(
        prog=MAIN_CMD_NAME,
        formatter_class=argparse.RawTextHelpFormatter,
        description="Python Environment Installer",
    )

    argument_parser.add_argument(
        "command",
        help="Choose a command. To see help for each command "
             'run with "-h" argument e.g.\n'
        f"{MAIN_CMD_NAME} install -h",
        choices=("install",),
    )

    args: argparse.Namespace = argument_parser.parse_args(args=sys.argv[1:2])
    command_name_cli_func_map: Dict[str, Callable] = {"install": install_cli}

    cli_func = command_name_cli_func_map[args.command]
    cli_func()
