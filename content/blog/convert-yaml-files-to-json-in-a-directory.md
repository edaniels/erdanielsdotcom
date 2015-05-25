+++
date = "2014-08-18 20:19:39+00:00"
title = "Convert YAML files to JSON in a directory"
type = "post"
+++

There is probably a much better way to do this but I got very excited having this all come together. This "one liner" requires the Perl modules JSON::XS and Catmandu.

<!--more-->
```bash
find dir/subdir -name "*.yml" -execdir sh -c 'catmandu convert YAML to JSON < {} | json_xs > `basename {} .yml`.json' \;
```


This is what the script does:



	
  1. Find all yml files and convert them into their JSON equivalents.

	
  2. Pipe the output into json_xs to prettify the JSON.

	
  3. Output the prettified JSON to the same file but with a json extension.


