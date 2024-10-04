# MakeSilicon

MakeSilicon is a streamlined toolkit for initializing FPGA and ASIC projects. It automates the creation of essential directories and integrates necessary scripts to set up your hardware development environment quickly and efficiently.

## Features

- **Automatic Project Setup**: Create new projects with a predefined directory structure.
- **Customizable Configuration**: Define which directories to include via `config.mk` or command-line arguments.
- **Template Integration**: Copy template scripts and files into new projects.
- **Optional Git Initialization**: Automatically initialize a git repository when creating a project.
- **User Initialization Script**: Customize project setup with your own commands in `init.sh`.
- **Safe Project Deletion**: Warns if there are uncommitted changes or unpushed commits before deleting a project.
- **Project Listing**: List all projects in the project directory.
- **Project Cleaning**: Delete a project and its contents.
- **Project Cloning**: Clone user repo list with a single command.

## Getting Started

1. List the available make commands:
   ```bash
   make help
   ```

2. Create a new project:
   ```bash
   make new PROJECT_NAME=my-project
   # if you don't want to initialize a git repository, you can use the `GIT_INIT` flag:
   make new PROJECT_NAME=my-project GIT_INIT=no
   ```


3. List the projects in the project directory:
    ```bash
    make list
   ```

4. Delete the project:
   ```bash
   make clean PROJECT_NAME=my-project
   ```

5. Clone the user repo list:
   ```bash
   make clone
   ```



### Prerequisites

- **Make**: Ensure that `make` is installed on your system.
- **Git**: Required if you plan to initialize a git repository.

## How to Contribute and Support

If you have any questions or suggestions, please feel free to [create an issue](https://github.com/bugratufan/make-silicon/issues/new) or pull request. You can also support this project by sharing it with others who might find it useful.

Please fork this repository and contribute back using [pull requests](https://github.com/bugratufan/make-silicon/pulls).


### Installation

Clone the MakeSilicon repository:

```bash
git clone https://github.com/bugratufan/make-silicon.git
```

### License

This project is licensed under GPL-2.0. See the [LICENSE](LICENSE) file for details.