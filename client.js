(function(){var require=function(file,cwd){var resolved=require.resolve(file,cwd||'/');var mod=require.modules[resolved];if(!mod)throw new Error('Failed to resolve module '+file+', tried '+resolved);var cached=require.cache[resolved];var res=cached?cached.exports:mod();return res;};require.paths=[];require.modules={};require.cache={};require.extensions=[".js",".coffee",".json"];require._core={'assert':true,'events':true,'fs':true,'path':true,'vm':true};require.resolve=(function(){return function(x,cwd){if(!cwd)cwd='/';if(require._core[x])return x;var path=require.modules.path();cwd=path.resolve('/',cwd);var y=cwd||'/';if(x.match(/^(?:\.\.?\/|\/)/)){var m=loadAsFileSync(path.resolve(y,x))||loadAsDirectorySync(path.resolve(y,x));if(m)return m;}
var n=loadNodeModulesSync(x,y);if(n)return n;throw new Error("Cannot find module '"+x+"'");function loadAsFileSync(x){x=path.normalize(x);if(require.modules[x]){return x;}
for(var i=0;i<require.extensions.length;i++){var ext=require.extensions[i];if(require.modules[x+ext])return x+ext;}}
function loadAsDirectorySync(x){x=x.replace(/\/+$/,'');var pkgfile=path.normalize(x+'/package.json');if(require.modules[pkgfile]){var pkg=require.modules[pkgfile]();var b=pkg.browserify;if(typeof b==='object'&&b.main){var m=loadAsFileSync(path.resolve(x,b.main));if(m)return m;}
else if(typeof b==='string'){var m=loadAsFileSync(path.resolve(x,b));if(m)return m;}
else if(pkg.main){var m=loadAsFileSync(path.resolve(x,pkg.main));if(m)return m;}}
return loadAsFileSync(x+'/index');}
function loadNodeModulesSync(x,start){var dirs=nodeModulesPathsSync(start);for(var i=0;i<dirs.length;i++){var dir=dirs[i];var m=loadAsFileSync(dir+'/'+x);if(m)return m;var n=loadAsDirectorySync(dir+'/'+x);if(n)return n;}
var m=loadAsFileSync(x);if(m)return m;}
function nodeModulesPathsSync(start){var parts;if(start==='/')parts=[''];else parts=path.normalize(start).split('/');var dirs=[];for(var i=parts.length-1;i>=0;i--){if(parts[i]==='node_modules')continue;var dir=parts.slice(0,i+1).join('/')+'/node_modules';dirs.push(dir);}
return dirs;}};})();require.alias=function(from,to){var path=require.modules.path();var res=null;try{res=require.resolve(from+'/package.json','/');}
catch(err){res=require.resolve(from,'/');}
var basedir=path.dirname(res);var keys=(Object.keys||function(obj){var res=[];for(var key in obj)res.push(key);return res;})(require.modules);for(var i=0;i<keys.length;i++){var key=keys[i];if(key.slice(0,basedir.length+1)===basedir+'/'){var f=key.slice(basedir.length);require.modules[to+f]=require.modules[basedir+f];}
else if(key===basedir){require.modules[to]=require.modules[basedir];}}};(function(){var process={};var global=typeof window!=='undefined'?window:{};var definedProcess=false;require.define=function(filename,fn){if(!definedProcess&&require.modules.__browserify_process){process=require.modules.__browserify_process();definedProcess=true;}
var dirname=require._core[filename]?'':require.modules.path().dirname(filename);var require_=function(file){var requiredModule=require(file,dirname);var cached=require.cache[require.resolve(file,dirname)];if(cached&&cached.parent===null){cached.parent=module_;}
return requiredModule;};require_.resolve=function(name){return require.resolve(name,dirname);};require_.modules=require.modules;require_.define=require.define;require_.cache=require.cache;var module_={id:filename,filename:filename,exports:{},loaded:false,parent:null};require.modules[filename]=function(){require.cache[filename]=module_;fn.call(module_.exports,require_,module_,module_.exports,dirname,filename,process,global);module_.loaded=true;return module_.exports;};};})();require.define("path",function(require,module,exports,__dirname,__filename,process,global){function filter(xs,fn){var res=[];for(var i=0;i<xs.length;i++){if(fn(xs[i],i,xs))res.push(xs[i]);}
return res;}
function normalizeArray(parts,allowAboveRoot){var up=0;for(var i=parts.length;i>=0;i--){var last=parts[i];if(last=='.'){parts.splice(i,1);}else if(last==='..'){parts.splice(i,1);up++;}else if(up){parts.splice(i,1);up--;}}
if(allowAboveRoot){for(;up--;up){parts.unshift('..');}}
return parts;}
var splitPathRe=/^(.+\/(?!$)|\/)?((?:.+?)?(\.[^.]*)?)$/;exports.resolve=function(){var resolvedPath='',resolvedAbsolute=false;for(var i=arguments.length;i>=-1&&!resolvedAbsolute;i--){var path=(i>=0)?arguments[i]:process.cwd();if(typeof path!=='string'||!path){continue;}
resolvedPath=path+'/'+resolvedPath;resolvedAbsolute=path.charAt(0)==='/';}
resolvedPath=normalizeArray(filter(resolvedPath.split('/'),function(p){return!!p;}),!resolvedAbsolute).join('/');return((resolvedAbsolute?'/':'')+resolvedPath)||'.';};exports.normalize=function(path){var isAbsolute=path.charAt(0)==='/',trailingSlash=path.slice(-1)==='/';path=normalizeArray(filter(path.split('/'),function(p){return!!p;}),!isAbsolute).join('/');if(!path&&!isAbsolute){path='.';}
if(path&&trailingSlash){path+='/';}
return(isAbsolute?'/':'')+path;};exports.join=function(){var paths=Array.prototype.slice.call(arguments,0);return exports.normalize(filter(paths,function(p,index){return p&&typeof p==='string';}).join('/'));};exports.dirname=function(path){var dir=splitPathRe.exec(path)[1]||'';var isWindows=false;if(!dir){return'.';}else if(dir.length===1||(isWindows&&dir.length<=3&&dir.charAt(1)===':')){return dir;}else{return dir.substring(0,dir.length-1);}};exports.basename=function(path,ext){var f=splitPathRe.exec(path)[2]||'';if(ext&&f.substr(-1*ext.length)===ext){f=f.substr(0,f.length-ext.length);}
return f;};exports.extname=function(path){return splitPathRe.exec(path)[3]||'';};exports.relative=function(from,to){from=exports.resolve(from).substr(1);to=exports.resolve(to).substr(1);function trim(arr){var start=0;for(;start<arr.length;start++){if(arr[start]!=='')break;}
var end=arr.length-1;for(;end>=0;end--){if(arr[end]!=='')break;}
if(start>end)return[];return arr.slice(start,end-start+1);}
var fromParts=trim(from.split('/'));var toParts=trim(to.split('/'));var length=Math.min(fromParts.length,toParts.length);var samePartsLength=length;for(var i=0;i<length;i++){if(fromParts[i]!==toParts[i]){samePartsLength=i;break;}}
var outputParts=[];for(var i=samePartsLength;i<fromParts.length;i++){outputParts.push('..');}
outputParts=outputParts.concat(toParts.slice(samePartsLength));return outputParts.join('/');};});require.define("__browserify_process",function(require,module,exports,__dirname,__filename,process,global){var process=module.exports={};process.nextTick=(function(){var canSetImmediate=typeof window!=='undefined'&&window.setImmediate;var canPost=typeof window!=='undefined'&&window.postMessage&&window.addEventListener;if(canSetImmediate){return function(f){return window.setImmediate(f)};}
if(canPost){var queue=[];window.addEventListener('message',function(ev){if(ev.source===window&&ev.data==='browserify-tick'){ev.stopPropagation();if(queue.length>0){var fn=queue.shift();fn();}}},true);return function nextTick(fn){queue.push(fn);window.postMessage('browserify-tick','*');};}
return function nextTick(fn){setTimeout(fn,0);};})();process.title='browser';process.browser=true;process.env={};process.argv=[];process.binding=function(name){if(name==='evals')return(require)('vm')
else throw new Error('No such module. (Possibly not yet loaded)')};(function(){var cwd='/';var path;process.cwd=function(){return cwd};process.chdir=function(dir){if(!path)path=require('path');cwd=path.resolve(dir,cwd);};})();});require.define("/lib/displaygame.coffee",function(require,module,exports,__dirname,__filename,process,global){(function(){var DisplayBoard,DisplayGame,DisplayPiece,Renderer;Renderer=require('./renderer');DisplayBoard=require('./displayboard');DisplayPiece=require('./displaypiece');module.exports=DisplayGame=(function(){function DisplayGame(elt){this.renderer=new Renderer(elt);this.board=new DisplayBoard(this.renderer);}
return DisplayGame;})();}).call(this);});require.define("/lib/renderer.coffee",function(require,module,exports,__dirname,__filename,process,global){(function(){var Renderer,__slice=[].slice;module.exports=Renderer=(function(){function Renderer(elt){this.elt=elt;this.ctx=this.elt.getContext('2d');}
Renderer.prototype.screenspace=function(x,y){return[((x-0.5)*this.elt.width)/8,((y-0.5)*this.elt.height)/8];};Renderer.prototype.rect=function(x1,y1,x2,y2,style){var _ref;this.ctx.fillStyle=style;return(_ref=this.ctx).fillRect.apply(_ref,__slice.call(this.screenspace(x1,y1)).concat(__slice.call(this.screenspace(x2,y2))));};Renderer.prototype.chara=function(x,y,c){var _ref;return(_ref=this.ctx).fillText.apply(_ref,[c].concat(__slice.call(this.screenspace(x,y))));};return Renderer;})();}).call(this);});require.define("/lib/displayboard.coffee",function(require,module,exports,__dirname,__filename,process,global){(function(){var DisplayBoard;module.exports=DisplayBoard=(function(){function DisplayBoard(renderer){this.renderer=renderer;this.draw();}
DisplayBoard.prototype.draw=function(){var style,x,y,_i,_j;for(x=_i=1;_i<=8;x=++_i){for(y=_j=1;_j<=8;y=++_j){style=(x+y)%2===0?'white':'black';this.renderer.rect(x-0.5,y-0.5,x+0.5,y+0.5,style);}}
this.renderer.chara(1,1,'♔');this.renderer.chara(2,1,'♔');this.renderer.chara(1,2,'X');return this.renderer.chara(2,2,'X');};return DisplayBoard;})();}).call(this);});require.define("/lib/displaypiece.coffee",function(require,module,exports,__dirname,__filename,process,global){(function(){var DisplayPiece;module.exports=DisplayPiece=(function(){function DisplayPiece(){}
return DisplayPiece;})();}).call(this);});require.define("/client.coffee",function(require,module,exports,__dirname,__filename,process,global){(function(){var DisplayGame;DisplayGame=require('./lib/displaygame');new DisplayGame(document.getElementById("board"));}).call(this);});require("/client.coffee");})();