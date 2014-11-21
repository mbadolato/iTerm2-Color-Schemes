import os

with open('README.md', 'w') as mkdn:
	mkdn.write("Screenshots\n===\n")
	for f in [f for f in os.listdir('.') if os.path.isfile(f)]:
		mkdn.write("`%s`\n\n" % f)
		mkdn.write("![image](%s)\n\n" % f)

