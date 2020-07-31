#!/bin/bash
cd $(dirname $0)
plantuml -tsvg *.plantuml
