echo '-- Deploy START -- ';

cd /home/forge/aurum.theboombitfactory.com

# Clean and pull latest changes.
git clean -fdx wp-content/plugins/
git clean -fdx wp-content/themes/
git clean -fdx wp-content/uploads/
git reset --hard
git checkout dev
git pull origin dev

# Create symblink to uploads directory
{ # try

    ln -s /home/forge/wordpress-uploads/aurum-uploads /home/forge/aurum.theboombitfactory.com/wp-content/uploads

} || { # catch
    # save log for exception 
    echo "Uploads link already exist."
}

( flock -w 10 9 || exit 1
    echo 'Restarting FPM...'; sudo -S service $FORGE_PHP_FPM reload ) 9>/tmp/fpmlock
    
cd /home/forge/aurum.theboombitfactory.com/wp-content/themes/aurum-child
npm install && gulp server

echo '-- Deploy END -- ';
