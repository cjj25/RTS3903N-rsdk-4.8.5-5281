# How To Use
- docker build . -t cjj25/rsdk-4.8.5-5281-el
- docker run --rm -it -v $(pwd)/src/:/to_build cjj25/rsdk-4.8.5-5281-el
- Activate the build env by running `source /toolchains/sdk/activate`
- All GCC etc will be setup ready to be used

# SDKs Included
- rsdk-4.8.5-5281-EL-3.10-u0.9.33-m32fut-161202
- rsdk-6.4.1-5281-EL-4.9-u1.0-m32fut-180611

# Swap Between SDKs
- Change "ARG TOOLCHAIN" in Dockerfile

# Credit
- Inspired from `https://github.com/mzpqnxow/realtek-mips-sdks`
- Activation scripts were copied from the above repo

# Keywords
- rsdk-4.8.5-5281-EL-3.10-u0.9.33-m32fut-161202
- rsdk-6.4.1-5281-EL-4.9-u1.0-m32fut-180611