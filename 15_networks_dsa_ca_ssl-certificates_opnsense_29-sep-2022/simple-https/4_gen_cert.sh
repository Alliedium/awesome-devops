#!/bin/bash
openssl x509 -req \
    -days 3650 \
    -in private.csr \
    -signkey private.key \
    -out public.crt \
    -extensions req_ext \
    -extfile ssl.conf
