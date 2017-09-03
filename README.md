# boost-build-installer
Windows installer for Boost.Build

This is a NSIS script which packages Windows builds of Boost.Build into executable installers.
The installer can adjust the PATH variable in order to make the tool immediately available.

# Usage instructions

(replace `<ARCH>` with your architecture, which is either amd64 or i386)

- Copy the Boost.Build directory to `boost-build-<ARCH>` in the project directory.
- Create a new file `boost-build-<ARCH>/version.txt` and write the version number in it.
- Execute `makensis -DARCH=<ARCH>`
