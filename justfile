# delete everything in 'public' folder
clean:
  rm -rf public/*

# build website and deploy to Github Pages
publish:
  hugo && ghp-import public -p  


