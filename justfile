# ================================================================================================ #
# Task list
#   - TODO: Reorganise this file
#   - TODO: Refactor the recipes
#   - TODO: Refactor Variables
#
# ================================================================================================ #

set dotenv-load

set quiet
set unstable

set shell := ["zsh", "-cu"]

# ================================================================================================ #
# Project Configration Helpers

# Common Paths
project_dir := justfile_directory()
out_dir     := project_dir/"out"
build_dir   := out_dir/"build"
install_dir := out_dir/"install"
res_dir     := project_dir/"res"
scripts_dir := project_dir/"scripts"
tools_dir   := project_dir/"tools"

# Project Information
project_version := shell("cat " + res_dir + "/VERSION")

# ================================================================================================ #
# Command-Line Helpers

# String prefix used by all error messages that the logger outputs to the term
error_msg := style("error") + "Error: " + NORMAL + BOLD

# Helper terminal command prefix to allow for easy just reciper calling
call_recipe := just_executable() + " --justfile=" + justfile()

# ================================================================================================ #
# Root Recipes

# Output usage and helpful command info for the project
help:
    @just --list --alias-style=separate --justfile {{justfile()}}
_default: help

# Output the projects version (SemVer) number
@version:
    echo "{{project_version}}"

# ================================================================================================ #
# Project Info

# Prints all info relating to this project
[group("info")]
info: && project-info system-info

# Output information on the projects current build/state
[group("info")]
@project-info:
    echo $'\n{{BOLD}}{{UNDERLINE}}Project Info{{NORMAL}}'
    echo "    {{BOLD}}Version:{{NORMAL}} {{project_version}}"

# Output current system information such as OS and Architecture
[group("info")]
@system-info:
    echo $'\n{{BOLD}}{{UNDERLINE}}System Info{{NORMAL}}'
    echo "   {{BOLD}}Architecture:{{NORMAL}} {{arch()}}"
    echo "   {{BOLD}}OS:{{NORMAL}} {{os()}}"
    echo "   {{BOLD}}OS Family:{{NORMAL}} {{os_family()}}"

# ================================================================================================ #
# File System Management

# Removes the provided files/dirs and cleans their data
[group("file-system")]
@clean-targets +targets:
    {{scripts_dir}}/clean-targets.sh {{targets}}

# Clean out all generated files (bui1ld, cache, etc) from the project
[group("file-system")]
@clean: ( clean-targets build_dir )

# ================================================================================================ #
# Setup and Configuration

# Generates the config data for CMake
[group("config")]
config:
    cmake -S . -B {{build_dir}}

# ================================================================================================ #
# Building and Compilation

# compilation
[group("build")]
build:
    cmake --build {{build_dir}}

# ================================================================================================ #

