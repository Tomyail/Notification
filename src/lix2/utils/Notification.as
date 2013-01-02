//------------------------------------------------------------------------------
//
//Copyright (c) 2013 Lixuexin 
// 
//Permission is hereby granted, free of charge, to any person 
//obtaining a copy of this software and associated documentation 
//files (the "Software"), to deal in the Software without 
//restriction, including without limitation the rights to use, 
//copy, modify, merge, publish, distribute, sublicense, and/or sell 
//copies of the Software, and to permit persons to whom the 
//Software is furnished to do so, subject to the following 
//conditions: 
// 
//The above copyright notice and this permission notice shall be 
//included in all copies or substantial portions of the Software. 
// 
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
//EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
//OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
//NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
//HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
//WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
//FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
//OTHER DEALINGS IN THE SOFTWARE. 
//
//------------------------------------------------------------------------------

package lix2.utils
{
	import flash.utils.Dictionary;
	/**
	 * 利用观察者模式实现的监听机制
	 */
	public class Notification
	{
		private static var autoRemoveDic:Dictionary = new Dictionary

		private static var notifications:Dictionary = new Dictionary

		/**
		 * 添加一个事件监听
		 * @param type 类型,类似于event的type,为了确保type的唯一可以尝试使用类名做前缀
		 * @param callback 回调函数
		 * @param autoRemove 在执行第一次回调函数之后是否自动删除监听
		 */
		public static function addNotification(type:String, callback:Function, autoRemove:Boolean = false):void
		{
			if (!notifications[type])
				notifications[type] = new <Function>[]; //http://jacksondunstan.com/articles/1168
			if (notifications[type].indexOf(callback) == -1)
				notifications[type].push(callback); //this is readable than notifications[type][notifications[type].length] = callback;...
			if (autoRemove)
				addAutoRemove(type, callback);
		}

		/**查询是否含有对应的监听类型*/
		public static function hasNotification(targetType:String):Boolean
		{
			return notifications[targetType] != null;
		}

		/**移除监听*/
		public static function removeNotification(type:String, callback:Function):void
		{
			if (!notifications[type])
				return;
			var findIndex:int = notifications[type].indexOf(callback);
			if (findIndex != -1)
				notifications[type].splice(findIndex, 1);
			if (notifications[type].length == 0)
				delete notifications[type];
		}

		/**发送监听事件*/
		public static function sendNotification(type:String, ... args):void
		{
			if (!notifications[type])
				return;
			var callback:Function;
			// 循环中加入notifications[type]值的是否为空的判断是因为removeNotification可能会将整个key删掉,那是就访问不到notifications[type]了
			for (var i:int = 0; notifications[type] && i < notifications[type].length; i++)
			{
				callback = notifications[type][i];
				callback.apply(null, args);
				if (autoRemoveDic[type] && autoRemoveDic[type][callback])
				{
					removeNotification(type, callback);
					delete autoRemoveDic[type][callback]
				}
			}
		}

		private static function addAutoRemove(type:String, callback:Function):void
		{
			if (!autoRemoveDic[type])
				autoRemoveDic[type] = new Dictionary(true);
			autoRemoveDic[type][callback] = true;
		}

		public function Notification()
		{
		}
	}
}
