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
	import flash.utils.getQualifiedClassName;

	public class Courier
	{
		private static var id:int=0;
		private var isSignal:Boolean
		
		public function Courier(isSingle:Boolean = false)
		{
			this.isSignal = isSingle;
			type=getQualifiedClassName(this) + (id++);
		}

		private var type:String;

		public function add(callback:Function, autoRemove:Boolean=false):void
		{
			if(isSignal)
			{
				if(!Notification.hasNotification(type))
				{
					Notification.addNotification(type, callback, autoRemove);
				}
			}
			else
			{
				Notification.addNotification(type, callback, autoRemove);
			}
		}

		public function send(... args):void
		{
			args.unshift(type);
			Notification.sendNotification.apply(null, args);
		}
	}
}
