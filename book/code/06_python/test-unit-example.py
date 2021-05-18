import pytest
from devsecops.lib.helper_functions import check_docker

def test_check_docker():
assert(check_docker())
