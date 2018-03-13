import getpass

from shell_executor import ShellExecutor


class GitOperations(object):

    def fetch_all_repos_and_reset_hard(self):
        shell_executor = ShellExecutor()
        system_user_name = getpass.getuser()
        git_folder_path = 'cd $SYSTEM_ROOT_GIT_REPO_FOLDER/'.format(
            system_user_name=system_user_name)
        project_folder_list = shell_executor.execute_shell_command(
            cmd='{git_folder_path} && ls -l'.format(git_folder_path=git_folder_path))
        del project_folder_list[0]
        project_folder_list = project_folder_list[:-1]

        for project_folder in project_folder_list:
            parts = project_folder.split(' ')
            project_name = parts[len(parts) - 1]
            project_folder_path = '{git_folder_path}{project_name}/'.format(
                git_folder_path=git_folder_path,
                project_name=project_name)
            shell_executor.execute_shell_command(
                cmd='{project_folder_path} && printf "yes\n" | git fetch --all && gitResetHard'.format(project_folder_path=project_folder_path))
            branch_name = shell_executor.execute_shell_command(
                cmd='{project_folder_path} && git branch'.format(project_folder_path=project_folder_path))
            branch_name = branch_name[0].replace('* ', '')
            print('======>>>>>', project_name, branch_name, 'DONE')
