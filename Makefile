all: check coverage

ig_posicion_trampas_for_next_week.csv: src/obtain_csv_from_mapsource_traps.R
	Rscript src/obtain_csv_from_mapsource_traps.R

.PHONY: \
    check \
    clean \
    coverage \
    format \
    init \
    install \
    setup \
    tests

check:
	R -e "library(styler)" \
      -e "resumen <- style_dir('R')" \
      -e "resumen <- rbind(resumen, style_dir('tests'))" \
      -e "resumen <- rbind(resumen, style_dir('tests/testthat'))" \
      -e "any(resumen[[2]])" \
      | grep FALSE

clean:
	rm --force *.tar.gz
	rm --force --recursive *.Rcheck
	rm --force --recursive tests/testthat/_snaps
	rm --force NAMESPACE

coverage: setup tests
	Rscript tests/testthat/coverage.R

format:
	R -e "library(styler)" \
      -e "style_dir('R')" \
      -e "style_dir('tests')" \
      -e "style_dir('tests/testthat')"

init: setup tests

setup: clean install

install:
	mkdir --parents data
	R -e "devtools::document()" && \
    R CMD build . && \
    R CMD check readMS_0.1.0.tar.gz && \
    R CMD INSTALL readMS_0.1.0.tar.gz

tests:
	Rscript -e "devtools::test(stop_on_failure = TRUE)"

red: format
	Rscript -e "devtools::test(stop_on_failure = TRUE)" && git restore R tests/testthat \
	|| (git add R/ tests/testthat/ && git commit -m "🛑🧪 Fail tests")
	chmod g+w -R .

green: format
	Rscript -e "devtools::test(stop_on_failure = TRUE)" \
	&& (git add R/ tests/testthat/ && git commit -m "✅ Pass tests") \
	|| git restore R tests/testthat
	chmod g+w -R .

refactor: format
	Rscript -e "devtools::test(stop_on_failure = TRUE)" \
	&& (git add R/ tests/testthat/ && git commit -m "♻️  Refactor") \
	|| git restore R tests/testthat
	chmod g+w -R .
