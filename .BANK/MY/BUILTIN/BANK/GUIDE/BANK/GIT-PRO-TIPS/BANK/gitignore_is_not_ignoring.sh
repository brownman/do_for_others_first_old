echo url: http://www.kickasslabs.com/2010/02/06/quick-hits-when-your-gitignore-file-gets-ignored/
echo [WTF]:
echo    Keep your .gitignore file.
echo    Clear your GIT cache.  Don’t worry, this won’t delete any of your local files, just what GIT is tracking.
    git rm -r --cached .
echo    Add everything in your project.  Your .gitignore file will exclude what you want to ignore now and start tracking the good stuff.
    git add .
echo     Commit your changes.
    git commit -m "Now my .gitignore file works correctly!"

