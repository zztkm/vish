module main

import os
import term
import readline
import vish_core.commands

fn get_one_line(prompt string) ?string {
	rline := readline.read_line(prompt) or { return none }
	return rline
}

fn exec(path string) string {
	mut out := ''
	mut line := ''
	mut cmd := os.Command{
		path: path
		redirect_stdout: true
	}
	cmd.start() or { panic(err) }

	for {
		line = cmd.read_line()
		println(line)
		out += line
		if cmd.eof {
			return out
		}
	}
	return out
}

fn main() {
	mut prompt := '> '

	for {
		prompt = '> '

		oline := get_one_line(prompt) or { break }
		line := oline.trim_space()
		args := line.split(' ')
		match args[0] {
			'' {
				continue
			}
			'exit' {
				break
			}
			'clear' {
				term.erase_clear()
				continue
			}
			'cd' {
				if args.len == 1 {
					commands.change_dir(os.home_dir())!
				} else {
					commands.change_dir(args[1]) or {
						eprintln(err)
						continue
					}
				}
			}
			else {
				exec(line)
			}
		}
	}
}
