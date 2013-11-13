package pagemanager.transition {
    import com.greensock.TweenLite;
    import com.greensock.TimelineLite;
    import com.greensock.easing.*;

	import starling.display.Sprite;
    import starling.core.Starling;

    public class Transition {
        public static var methods:Object = {
            _getXYCenterFromScale: function(s:Sprite, param:Number):Object{
                var sX:Number = s.scaleX, sY:Number = s.scaleY, x:Number, y:Number;
                s.scaleX = s.scaleY = 1;
                x           = (s.width - (s.width * param)) / 2;
                y           = (s.height - (s.height * param)) / 2;
                s.scaleX    = sX;
                s.scaleY    = sY;

                return {x: x, y: y};
            },
            xTo: function(s:Sprite, param:Number){
                return {x: param};
            },
            xFromTo: function(s:Sprite, params:Object){
                s.x = params.from;

                return this.xTo(s, params.to);
            },
            yTo: function(s:Sprite, param:Number){
                return {y: param};
            },
            yFromTo: function(s:Sprite, params:Object){
                s.y = params.from;

                return this.yTo(s, params.to);
            },
            toLeft: function(s:Sprite):Object {
                return this.xFromTo(s, {from: 0, to: -s.width});
            },
            fromLeft: function(s:Sprite):Object {
                var center:Object = this._getXYCenterFromScale(s, s.scaleX);

                return this.xFromTo(s, {from: -s.width, to: center.x});
            },
            toRight: function(s:Sprite):Object {
                return this.xFromTo(s, {from: 0, to: s.width});
            },
            fromRight: function(s:Sprite):Object {
                var center:Object = this._getXYCenterFromScale(s, s.scaleX);

                return this.xFromTo(s, {from: Starling.current.stage.stageWidth, to: center.x});
            },
            toUp: function(s:Sprite):Object {
                return this.yFromTo(s, {from: 0, to: -s.height});
            },
            fromUp: function(s:Sprite):Object {
                var center:Object = this._getXYCenterFromScale(s, s.scaleY);

                return this.yFromTo(s, {from: -s.height, to: center.y});
            },
            toDown: function(s:Sprite):Object {
                return this.yFromTo(s, {from: 0, to: s.height});
            },
            fromDown: function(s:Sprite):Object {
                var center:Object = this._getXYCenterFromScale(s, s.scaleY);

                return this.yFromTo(s, {from: -Starling.current.stage.stageHeight, to: center.y});
            },
            scaleTo: function(s:Sprite, param:Number):Object {
                var center:Object = this._getXYCenterFromScale(s, param);

                return {x: center.x, y: center.y, scaleX: param, scaleY: param};
            },
            scaleFromTo: function(s:Sprite, params:Object):Object {
                var center:Object = this._getXYCenterFromScale(s, params.from);
                s.x         = center.x;
                s.y         = center.y;
                s.scaleX    = params.from;
                s.scaleY    = params.from;

                return this.scaleTo(s, params.to);
            },
            opacityTo: function(s:Sprite, param:Number):Object {
                return {alpha: param};
            },
            opacityFromTo: function(s:Sprite, params:Object):Object {
                s.alpha = params.from;

                return this.opacityTo(s, params.to);
            }
        };

        public function Transition () {}

        public static function me (s:Sprite, name:String, time:Number, params:Object = null):* {
            var _ani = TransitionCreator.data[name],
                _timeline:TimelineLite = new TimelineLite({onComplete: (params && params.onComplete) ? params.onComplete : null, onCompleteParams: [s]}),
                _params:Vector.<Object> = new Vector.<Object>(_ani.length);

            Transition._reset(s);

            for( var j:int = _ani.length - 1; j >= 0; j--){
                _params[j] = {};

                for each(var i:Object in _ani[j].steps){
                    _params[j] = Extend.get(_params[j], (i.params !== null ? Transition.methods[i.name](s, i.params) : Transition.methods[i.name](s)));
                }

                _params[j].delay               = (_ani[j].delay * time) + (j == 0 && params && params.delay ? params.delay : 0);
                _params[j].ease                = _ani[j].ease;
                _params[j].onComplete          = _ani[j].onComplete;
                _params[j].onCompleteParams    = [s];
            }

            for( j = 0; j < _ani.length; j++){
                _timeline.append(new TweenLite(s, _ani[j].time * time, _params[j]));
            }

            _timeline.play();

            return Transition;
        }

        private static function _toFront (s:Sprite):void {
            s.parent.setChildIndex(s, s.parent.numChildren - 1);
        }

        private static function _reset (s:Sprite):void {
            s.scaleX     = s.scaleY = 1;
            s.rotation   = 0;
            s.x          = 0;
            s.y          = 0;
            s.alpha      = 1;
            s.visible    = true;

            _toFront(s);
        }

    }
}
