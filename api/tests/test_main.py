""" Testing main.py """

import sys

from starlette.testclient import TestClient

sys.path.append(".")
from api.main import app

client = TestClient(app)


def test_main():
    response = client.get("/test/", json={"name": "thename!"})
    assert response.status_code == 200
    assert response.json() == {"name": "thename!"}
