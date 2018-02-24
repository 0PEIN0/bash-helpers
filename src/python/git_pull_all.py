import getpass
import subprocess


def execute_shell_command(cmd):
    std_response = subprocess.Popen(cmd,
                                    shell=True,
                                    executable='/bin/zsh',
                                    stdout=subprocess.PIPE).stdout.read().decode('utf-8')
    lines = std_response.split('\n')
    return lines


system_user_name = getpass.getuser()
git_folder_path = 'cd /home/{system_user_name}/Gitrepos/'.format(
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
        cmd='{project_folder_path} && git fetch --all && branchName="$(git rev-parse --abbrev-ref HEAD)" && git reset --hard origin/'.format(project_folder_path=project_folder_path) + '"${branchName}"')
    branch_name = execute_shell_command(
        cmd='{project_folder_path} && git branch'.format(project_folder_path=project_folder_path))
    branch_name = branch_name[0].replace('* ', '')
    print('======>>>>>', project_name, branch_name, 'DONE')
