import logging
from pathlib import Path

Path("/var/log/devsecops").mkdir(parents=True, exist_ok=True)
logging.basicConfig(
    filename="/var/log/devsecops/devsecops.log",
    level=logging.DEBUG,
    format="[%(asctime)s] [%(filename):%(lineno) - %(funcName) - %(processName)] %(levelname) - %(message)"
)
