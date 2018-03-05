import getpass
import subprocess

LOCAL_SETTINGS = {}

try:
    from local_settings import LOCAL_SETTINGS
except Exception as ex:
    pass


def execute_shell_command(cmd):
    cmd = '. {bash_alias_path}; source {bash_alias_path};'.format(
        bash_alias_path=LOCAL_SETTINGS['BASH_ALIASES_FILE_PATH']) + cmd
    std_response = subprocess.Popen(cmd,
                                    shell=True,
                                    executable='/bin/zsh',
                                    stdout=subprocess.PIPE).stdout.read().decode('utf-8')
    lines = std_response.split('\n')
    return lines


system_user_name = getpass.getuser()
git_folder_path = 'cd $SYSTEM_ROOT_GIT_REPO_FOLDER/'.format(
    system_user_name=system_user_name)
project_folder_list = execute_shell_command(
    cmd='{git_folder_path} && ls -l'.format(git_folder_path=git_folder_path))
del project_folder_list[0]
project_folder_list = project_folder_list[:-1]

for project_folder in project_folder_list:
    parts = project_folder.split(' ')
    project_name = parts[len(parts) - 1]
    project_folder_path = '{git_folder_path}{project_name}/'.format(
        git_folder_path=git_folder_path,
        project_name=project_name)
    res = execute_shell_command(
        cmd='{project_folder_path} && printf "yes\n" | git fetch --all && gitResetHard'.format(project_folder_path=project_folder_path))
    branch_name = execute_shell_command(
        cmd='{project_folder_path} && git branch'.format(project_folder_path=project_folder_path))
    branch_name = branch_name[0].replace('* ', '')
    print('======>>>>>', project_name, branch_name, 'DONE')
