News Generator
==============

A news generator created with Processing

## What does it do?
Generates fake news headlines based on a database of given words and outputs it as a typical news poster
![Examples](https://github.com/andreaskoller/News-Generator/blob/gh-pages/images/news-generator-examples.jpg?raw=true)

## How to use it
 - Edit the word database in the folder data/words:
  - In data/words, every type of word (adverbial, object, subject, transverb) has one text file, with one word each line
  - % is a line break within a phrase
 - Define the structure of sentences in data/template.txt:
  - e.g. <subject> will be replaced with a word from subject.txt
  - define rules according to the syntax that rita provides (see link below)
  - add new types of words in data/template.txt and provide a new text file in data/words
 - Edit the backgrounds
  - Put svg files into folder data/backgrounds 
 - Download the font used http://www.dafont.com/ktf-roadbrush.font or use your own
 - Compile in Processing
 - Interact
  - Press SPACE to generate a new text
  - Press 'S' to save PDF
  - Press 'P' to print directly from Processing sketch
  - Add new words or change structure while running the sketch, as it will be reloaded every time (was necessary for live performance)

## Programming
Andreas Koller

## Idea & Design
Jaap de Maat

## Dependencies
- Rita Library http://www.rednoise.org/rita/
- Processing http://processing.org (tested with Processing 1.5.1 and 2.0b8)
