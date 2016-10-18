hexo clean
hexo generate
cp -R public/* .deploy/giftman.github.io
cd .deploy/giftman.github.io
git add .
git commit -m “update”
git push origin master
