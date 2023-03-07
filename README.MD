# JsonHelper

JQ in a web package. 

## Usage

use it for instance with low code platforms to select JSON properties without a loop.

## Architecture

```
,-----.  ,-------.   ,-----------.   ,--.
|NGinx|  |FastCGI|   |bash script|   |JQ|
|-----|--|-------|---|-----------|---|--|
`-----'  `-------'   `-----------'   `--'
```

## Web interface

for ease of use the root serves a small web frontend

## API

use /api?q=<code>{jq filter}</code> for raw jq filters 

or

use /api?select=<code>{prop1,prop2,prop3}</code> as a property selector

and

use the body to post the input JSON.