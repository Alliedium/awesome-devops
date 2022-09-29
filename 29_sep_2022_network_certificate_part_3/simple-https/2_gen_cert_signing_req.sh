#!/bin/bash
openssl req -new -sha256 \
    -out private.csr \
    -key private.key \
    -config ssl.conf \
    -batch  # feel free to remove -batch to enable an interactive mode
