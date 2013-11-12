package pagemanager {

    import starling.core.Starling;
    import starling.display.Sprite;
	
	import pagemanager.transition.Transition;
	import pagemanager.transition.TransitionCreator;
	
	import com.greensock.easing.*;

    public class PageManager {
        public static var main:Sprite;
        public static var current:String;
        private static var _pages:Object                = {};
        private static var _inTransition:Boolean        = false;

        public static function add (name:String, page:Sprite):void {
            page.visible = false;

            PageManager._pages[name] = page;
            PageManager.main.addChild(page);
        }

        public static function get (name:String):Sprite {
            return PageManager._pages[name];
        }

        public static function go (name:String, transition:Function):void {
            trace('PageManager: ' + name);

            var next:*      = PageManager.get(name),
                cur:*       = PageManager.get(PageManager.current);

            transition = transition ? transition : Transitions.default;

            next.visible = true;

            if(!PageManager._inTransition){
                PageManager._inTransition = true;

                transition(cur, next, function ():void { PageManager._inTransition = false; });
            }
        }

        public static function initTransitions () {
            // To
            TransitionCreator
                .make('toLeft')
                    .group(1, Expo.easeInOut, {onComplete: function(s:Sprite):void { s.visible = false; }})
                        .add('toLeft');

            TransitionCreator
                .make('toRight')
                    .group(1, Expo.easeInOut, {onComplete: function(s:Sprite):void { s.visible = false; }})
                        .add('toRight');

            TransitionCreator
                .make('toUp')
                    .group(1, Expo.easeInOut, {onComplete: function(s:Sprite):void { s.visible = false; }})
                        .add('toUp');

            TransitionCreator
                .make('toDown')
                    .group(1, Expo.easeInOut, {onComplete: function(s:Sprite):void { s.visible = false; }})
                        .add('toDown');

            // From
            TransitionCreator
                .make('fromLeft')
                    .group(1, Expo.easeInOut)
                        .add('fromLeft');

            TransitionCreator
                .make('fromRight')
                    .group(1, Expo.easeInOut)
                        .add('fromRight');

            TransitionCreator
                .make('fromUp')
                    .group(1, Expo.easeInOut)
                        .add('fromUp');

            TransitionCreator
                .make('fromDown')
                    .group(1, Expo.easeInOut)
                        .add('fromDown');

            // Opacity
            TransitionCreator
                .make('fadeIn')
                    .group(1, Expo.easeInOut)
                        .add('toOpacity', 1);

            TransitionCreator
                .make('fadeOut')
                    .group(1, Expo.easeInOut, {onComplete: function(s:Sprite):void { s.visible = false; }})
                        .add('fromOpacity', 1);

            // Scale
            TransitionCreator
                .make('scaleToUp')
                    .group(1, Expo.easeInOut, {onComplete: function(s:Sprite):void { s.visible = false; }})
                        .add('scaleFromTo', {from: 1, to: 1.3})
                        .add('opacityFromTo', {from: 1, to: 0});

            TransitionCreator
                .make('scaleFromUp')
                    .group(1, Expo.easeInOut)
                        .add('scaleFromTo', {from: 1.3, to: 1})
                        .add('opacityFromTo', {from: 0, to: 1});

            TransitionCreator
                .make('scaleToDown')
                    .group(1, Expo.easeInOut, {onComplete: function(s:Sprite):void { s.visible = false; }})
                        .add('scaleFromTo', {from: 1, to: .7})
                        .add('opacityFromTo', {from: 1, to: 0});

            TransitionCreator
                .make('scaleFromDown')
                    .group(1, Expo.easeInOut)
                        .add('scaleFromTo', {from: .7, to: 1})
                        .add('opacityFromTo', {from: 0, to: 1});

            // Complex
            TransitionCreator
                .make('scaleToDownThenLeft')
                    .group(.6, Expo.easeInOut)
                        .add('scaleFromTo', {from: 1, to: .7})
                        .add('opacityFromTo', {from: 1, to: .5})
                    .group(.4, Expo.easeInOut)
                        .add('toLeft');

            TransitionCreator
                .make('scaleToDownThenRight')
                    .group(.6, Expo.easeInOut)
                        .add('scaleFromTo', {from: 1, to: .7})
                        .add('opacityFromTo', {from: 1, to: .5})
                    .group(.4, Expo.easeInOut)
                        .add('toRight');

            TransitionCreator
                .make('fromLeftThenScaleFromDown')
                    .group(.4, Expo.easeInOut)
                        .add('fromLeft')
                        .add('opacityFromTo', {from: .5, to: .5})
                    .group(.6, Expo.easeInOut)
                        .add('scaleFromTo', {from: .7, to: 1})
                        .add('opacityFromTo', {from: .5, to: 1});

            TransitionCreator
                .make('fromRightThenScaleFromDown')
                    .group(.4, Expo.easeInOut)
                        .add('fromRight')
                        .add('opacityFromTo', {from: .5, to: .5})
                    .group(.6, Expo.easeInOut)
                        .add('scaleFromTo', {from: .7, to: 1})
                        .add('opacityFromTo', {from: .5, to: 1});
        }
    }
}
