from setuptools import setup

setup(
    # Needed to silence warnings (and to be a worthwhile package)
    name='template',
    url='https://github.com/slavayssiere-spoon/template',
    author='Sebastien Lavayssiere',
    author_email='sebastien.lavayssiere@spoon.ai',
    # Needed to actually package something
    packages=['template'],
    # Needed for dependencies
    install_requires=[''],
    # *strongly* suggested for sharing
    version='0.1',
    # The license can be anything you like
    license='MIT',
    description='For SPooN Cloud template',
    # We will also need a readme eventually (there will be a warning)
    # long_description=open('README.txt').read(),
)