require './app/application'

Services::Editions::ImportAll.perform('AllSets-x.json')
