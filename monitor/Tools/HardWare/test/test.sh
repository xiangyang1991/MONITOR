#!/bin/bash
 /usr/local/bin/pdsh -w 10.136.65.[16-51],10.136.64.[28-45] "mount | grep \"data\" | grep \"LeoFS\"| awk '{print \$3}'"
