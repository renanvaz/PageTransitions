package pagemanager.transition {

    public class TransitionCreator {
        private static var index:int    = 0;
        private static var name:String  = '';
        public static var data:Object  = {};

        public function TransitionCreator () {}

        public static function make (name:String) {
            TransitionCreator.index     = -1;
            TransitionCreator.name      = name;
            TransitionCreator.data[TransitionCreator.name]   = [];

            return TransitionCreator;
        }

        public static function group (time:Number, ease:*, params:Object = null):* {
            var delay       = (params && params.delay) ? params.delay : 0;
            var onComplete  = (params && params.onComplete) ? params.onComplete : null;

            TransitionCreator.data[TransitionCreator.name][++TransitionCreator.index] = {time: time, delay: delay, ease: ease, onComplete: onComplete, steps: []};

            return TransitionCreator;
        }

        public static function add (name:String, params:* = null):* {
            TransitionCreator.data[TransitionCreator.name][TransitionCreator.index].steps.push({name: name, params: params});

            return TransitionCreator;
        }
    }
}
