BEGIN {
	RS = "<";
	FS = ">";
}
tolower($1) ~ /^link.+rel[ \t\f\n\r\v]*=[ \t\f\n\r\v]*(\"lrdd\"|\'lrdd\'|lrdd)/ {
	template = $1;
	addr = ENVIRON["WEBFINGERID"];
	match(template, /template[ \t\f\n\r\v]*=[ \t\f\n\r\v]*((\".*\"|\'.*\'))/);
	if(RLENGTH < 0) {
		print "template attribute not found"
		exit 1;
	}
	template = substr(template, RSTART, RLENGTH);
	sub(/^template[ \t\f\n\r\v]*=[ \t\f\n\r\v]*[\'\"]/, "", template);
	sub(/[\'\"]$/, "", template);
	gsub(/\{uri\}/, addr, template);
	print template;
	exit 0;
}
