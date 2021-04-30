#!/bin/bash
 
function processFiles ()
{
 FILES=`ls "${1}"`                # Lista los archivos del directorio
                                   # que se recibe como argumento.
 
 for FILE in $FILES; do           # Recorre la lista.
     NEW_PATH="${1}/${FILE}"
 
     if [ -d $NEW_PATH ]; then    # El archivo es un directorio.
         processFiles "${NEW_PATH}"   # Escanea ese directorio.
     else                         # El archivo NO es un directorio. 
         # Si el archivo es un .jpg o un .png muestra su path y lo convierte a webp:
         if [ "${NEW_PATH##*.}" == "png" ] ; then
             echo "$NEW_PATH"                
             cwebp -q 70 "$NEW_PATH" -o "${NEW_PATH%.png}.webp" 1>&2 2> /dev/null
             rm -rf "$NEW_PATH"
         elif [ "${NEW_PATH##*.}" == "jpg" ] ; then
             echo "$NEW_PATH"                
             cwebp -q 70 "$NEW_PATH" -o "${NEW_PATH%.jpg}.webp" 1>&2 2> /dev/null
             rm -rf "$NEW_PATH"
         fi
     fi
 done
}
  
processFiles $1 