# Installation

Install [ripgrep](https://github.com/BurntSushi/ripgrep#installation)

## Java
* I tried configuring JDTLS with Mason, but to no avail :(.
1. Install OpenJDK-17 with OpenJRE-17 (eclipse.jdt.ls requires Java 17 as of March, 2023) 
    * `sudo apt install openjdk-17-jdk openjdk-17-jre`
2. Download latest version of java lsp: [jdtls](https://download.eclipse.org/jdtls/milestones/) 
3. Extract it to `~/home/%USERNAME%/jdtls`
4. Download latest [lombok.jar](https://projectlombok.org/download)
5. Place it in `~/home/%USERNAME%/jdtls/plugins/`
6. Install [Java Debug Server](https://github.com/microsoft/java-debug)
and follow its installation instructions. (I tried it with Java 19 was installed, 
but it didn't work as of March, 2023. If you have any problems with building server, 
try uninstalling Java19)
7. You may also need to change paths to JDKs in `ftplugin/java.lua` in `settings`
option in `config` variable.

## C/C++
1. Install linters / static analyzers
    * `sudo apt install clang-tools`
    * `sudo apt install cppcheck` 

## Python 
Follow instructions for [debugpy](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python)

## Rust
Just works

## Go
`go install github.com/mgechev/revive@latest`

