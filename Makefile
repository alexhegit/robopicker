.PHONY: format lint test rocm-sync rocm-format rocm-lint rocm-test

# ---------------------------------------------------------------------------
# CUDA (default) — uses .venv
# ---------------------------------------------------------------------------

format:
	uv run ruff format
	uv run ruff check --fix

lint:
	uv run ruff check

test:
	uv run pytest

# ---------------------------------------------------------------------------
# ROCm — uses .venv-rocm (created by scripts/setup-rocm.sh)
#
#   make rocm-sync        # create/update .venv-rocm
#   make rocm-test        # run tests in ROCm venv
#   make rocm-format      # format in ROCm venv
#   make rocm-lint        # lint in ROCm venv
# ---------------------------------------------------------------------------

ROCM_PY := .venv-rocm/bin/python

rocm-sync:
	scripts/setup-rocm.sh

rocm-test:
	$(ROCM_PY) -m pytest

rocm-format:
	.venv-rocm/bin/ruff format
	.venv-rocm/bin/ruff check --fix

rocm-lint:
	.venv-rocm/bin/ruff check
