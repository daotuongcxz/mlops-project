from setuptools import setup, find_packages

with open("requirements.txt") as f: 
    requirements = f.read().splitlines()

setup(
    name="MLOPS-k6",
    version="0.1",
    author="truongnd",
    packages=find_packages(),
    install_requires = requirements,
)