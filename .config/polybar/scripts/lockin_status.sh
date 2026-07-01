#!/bin/bash

# The main goal of this script is to show the 
# subject to study on the current day
# for this I first get the current day in the following format:
# Lunes | Martes | Miercoles
# And depending on the day, It'll print something like:
# Matematicas | Estudio Scheme

now=`date +"%A"` # Lunes, Martes, etc

case $now in
  Monday)
	echo "Leer libro"
	;;
  Tuesday)
	echo "Practica Scheme"
	;;
  Wednesay)
	echo "Leer libro"
	;;
  Thursday)
	echo "Project Euler"
	;;
  Friday)
	echo "Descanso"
	;;
  Saturday)
	echo "Libro y Scheme"
	;;
  Sunday)
	echo "Descanso"
	;;
  *)
	;;
esac

