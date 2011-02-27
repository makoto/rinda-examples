require 'rinda/rinda'
a = []
DRb.start_service('druby://:12345', a)
