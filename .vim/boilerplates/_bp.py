#!/usr/bin/env python3

__doc__ = """Python script boilerplate.

A basic Python script boilerplate for Vim.
"""


import os
import sys
import configparser


class AppInfo:
	Name	      = "Foobar"
	Version       = "0.1"
	Website       = "http://example.com"
	ConfigFile    = "foobar.ini"
	DefaultConfig = """[app]
message = "Hello world!"
"""


def version_info():
	"""Show script name and version.
	"""
	print(AppInfo.Name + " " + AppInfo.Version)


def usage(out = sys.stdout):
	"""Show usage help.

	Show an usage help for the script inscluding all the command line options.

	Args:
		out: The output stream, for example sys.stderr. Defaults to sys.stdout.
	"""
	print("Usage: {0} [options]".format(sys.argv[0]), file=out)
	print("Options:", file=out)
	print("\t-h, --help     Show this help", file=out)
	print("\t-V, --version  Show program name and version", file=out)


def load_config(filename: str, default_config: str = "") -> configparser.ConfigParser:
	"""Load the config file.

	Load the configuration file (INI format) using configparser.

	If it does not exist yet, and a non-zero length value for default_config
	was given, a new file is created.

	Tries to follow the XDG standard and used $XDG_CONFIG_HOME if set.
	If not, either PyXDG or the hard-coded default ~/.config is used.

	Args:
		filename(str): The file's basename.
		default_config(str): The default config file contents.

	Returns:
		A configparser.ConfigParser object loaded with our config file.
	"""
	# Try to get value for XDG_CONFIG_HOME:
	#  - First, try the environment variable (highest priority)
	xdg_config = os.getenv("XDG_CONFIG_DIR", "")
	if len(xdg_config) < 1:
		try:
			# Use PyXDG if available
			import xdg
			xdg_config = xdg.BaseDirectory.xdg_config_home
		except ImportError:
			# Fall back to ~/.config
			xdg_config = "~/.config"

	# Support "~" in the path
	xdg_config = os.path.expanduser(xdg_config)

	# Get the absolute path of the config file
	config_fullpath = os.path.join(xdg_config, filename)
	print("[DEBUG]  config_fullpath=\"" + config_fullpath + "\"", file=sys.stderr)

	# Create a new config file with some default values
	if not os.path.exists(config_fullpath) and len(default_config) > 0:
		print("Creating config file with default values")
		f = open(config_fullpath, "w+")
		f.write(default_config)
		f.close()
		import pprint
		pprint.pprint(open(config_fullpath, "r").readlines())

	if not os.path.exists(config_fullpath):
		import errno
		raise FileNotFoundError(errno.ENOENT, os.strerror(errno.ENOENT), filename)

	# Debugging: Read config file
	print("[DEBUG]  Config file:", file=sys.stderr)
	with open(config_fullpath, "r") as f:
		for l in f.readlines():
			l = l.rstrip("\n")
			print("[DEBUG]      " + l, file=sys.stderr)

	# Load the file using configparser
	config = configparser.ConfigParser()
	config.read(config_fullpath)

	return config


def main():
	print("[DEBUG]  main()", file=sys.stderr)
	if "--version" in sys.argv or "-V" in sys.argv:
		version_info()
		sys.exit(0)

	elif "--help" in sys.argv or "-h" in sys.argv or "/?" in sys.argv:
		usage()
		sys.exit(0)

	elif len(sys.argv) > 1:
		for arg in sys.argv[1:]:
			if arg != "--" and arg.startswith("-"):
				print("Unknown option: " + arg, file=sys.stderr)
				usage(sys.stderr)
				sys.exit(1)

	config = load_config(
		AppInfo.ConfigFile,
		AppInfo.DefaultConfig
		# DefaultConfig
	)

	print("Hello world!")


if __name__ == "__main__":
	main()

