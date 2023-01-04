> module-report.txt (
	for %%f in (%~dp0*.jar) do (
		jar --file=%%f --describe-module
	)
)