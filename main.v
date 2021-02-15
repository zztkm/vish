module main

import os
import term
import readline

fn get_one_line(prompt string) ?string {
	rline := readline.read_line(prompt) or {
		return none
	}
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
	mut wd := os.getwd()
	mut prompt := wd + '> '

	for {
		wd = os.getwd()
		prompt = wd + '> '

		oline := get_one_line(prompt) or { break }
		line := oline.trim_space()

		if line == 'exit' {
			break
		}

		if line == '\n' {
			continue
		}

		if line == 'clear' {
			term.erase_clear()
			continue
		}

		println(line)
		// exec(line)
	}
}
