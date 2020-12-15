#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

class AppInfo(object):
	Name    = "Foobar"
	Version = "0.1"
	Website = "http://example.com"
	
def main():
	if "--version" in sys.argv or "-V" in sys.argv:
		print(AppInfo.Name + " " + AppInfo.Version)
		sys.exit(0)
		
	elif "--help" in sys.argv or "-h" in sys.argv or "/?" in sys.argv:
		print("Usage: {0} [options]".format(sys.argv[0]))
		print("Options:")
		print("\t-h, --help     Show this help")
		print("\t-V, --version  Show program name and version")
		sys.exit(0)
	elif len(sys.argv) > 1:
		for arg in sys.argv[1:]:
			if arg != "--" and arg.startswith("-"):
				print("Unknown option: "+arg)
				sys.exit(1)
	
	print("Hello world!")
	
if __name__ == "__main__":
	main()
	
