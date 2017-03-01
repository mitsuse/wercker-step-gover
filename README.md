# wercker-step-gover

[![License](https://img.shields.io/badge/license-MIT-yellowgreen.svg?style=flat-square)](LICENSE.txt)

[Wercker][wercker] step for [modocache/gover][gover].
Create and aggregate test coverage reports.

[wercker]: https://app.wercker.com/
[gover]: https://github.com/modocache/gover


## Usage

Add the step to the build steps of `wercker.yml` as follows:

```yaml
build:
    steps:
        - mitsuse/gover:
            exclude: "pb"
            report: "coverage.txt"
```


## Properties

- `exclude`: Exclude certain files. Uses grep -ve to do the exclude(vendor is default exclude)
- `report`: the output name of the aggregated coverage report


## License

Please read [LICENSE.txt](LICENSE.txt)
