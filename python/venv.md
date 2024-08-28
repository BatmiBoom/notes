# Virtual Environments

`venv` are Python's way to keep dependencies separate from other projects on our machine.

As a best practice, each Python project on your machine should have its own virtual environment to keep them isolated from each other.

**To create a virtual environment**

```bash
python3 -m venv name_of_the_virtual_env
```

**Activate the virtual environment**

- On linux/mac

```bash
source name_of_the_virtual_env/bin/actvate
```

- On Windows

```bash
name_of_the_virtual_env/Scripts/actvate
```

## Dependencies

Create a file called `requirements.txt` in the top level of your project directory with the following contents:

```requirements.txt
dependencie==version
```

### Installing dependencies

```
pip install -r requirements.txt
```
