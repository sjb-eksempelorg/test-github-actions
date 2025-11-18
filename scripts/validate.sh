set -e

# finn workdir

echo "Finner sti til terraform prosjekt..."
WORKDIR_IN="${1:-.}"

if [[ -z "${WORKDIR_IN}" ]]; then
  echo "Bruk: $0 <WORKDIR> [..]" >&2
  exit 2
fi

if [[ "${WORKDIR_IN}" != /* ]]; then
  WORKDIR_CANDIDATE="${PWD}/${WORKDIR_IN}"
else
  WORKDIR_CANDIDATE="${WORKDIR_IN}"
fi

WORKDIR_ABS="$(cd "${WORKDIR_CANDIDATE}" 2>/dev/null && pwd -P)" || {
  echo "Fant ikke WORKDIR: ${WORKDIR_IN}" >&2
  exit 3
}

pushd "${WORKDIR_ABS}" >/dev/null
echo "Sti WORKDIR ${WORKDIR_ABS} er klar."

# terraform validate
#echo ""
#echo "[1/1] terraform validate"
#terraform validate

# tflint
echo ""
echo "[1/2] tflint --init"
tflint --init

echo "[2/2] tflint"
tflint

# checkov
echo ""
echo "[1/1] checkov -d . --framework terraform"
checkov -d . --framework terraform

echo ""
echo "Completed validation script"