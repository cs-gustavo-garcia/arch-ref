if [ -f ./scripts/export_values.sh ]
then
source ./scripts/export_values.sh
else
echo "error: Environment variables not found"
exit 1
fi

./Pods/Sourcery/bin/sourcery --disableCache