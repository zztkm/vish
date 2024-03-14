module commands

import os

// change_dir changes the current working directory to the given path
pub fn change_dir(path string) ! {
	os.chdir(path)!
}
