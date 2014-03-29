while IFS= read -r -d $'\0' file; do
echo  sed -i 's/string2/string2/g' "$file"
done < <(find ./ -type f -print0)

