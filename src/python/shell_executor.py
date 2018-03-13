import subprocess

from local_settings_loader import LocalSettingsLoader


class ShellExecutor(object):

    BASH_ALIASES_FILE_PATH = ''

    def __init__(self):
        self.BASH_ALIASES_FILE_PATH = LocalSettingsLoader(
        ).LOCAL_SETTINGS['BASH_ALIASES_FILE_PATH']

    def execute_shell_command(self, cmd):
        cmd = '. {bash_alias_path}; source {bash_alias_path};'.format(
            bash_alias_path=self.BASH_ALIASES_FILE_PATH) + cmd
        std_response = subprocess.Popen(cmd,
                                        shell=True,
                                        executable='/bin/zsh',
                                        stdout=subprocess.PIPE).stdout.read().decode('utf-8')
        lines = std_response.split('\n')
        return lines
