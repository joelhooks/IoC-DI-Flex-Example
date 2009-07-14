/*
	Inversion of Control/Dependency Injection Using Parsley
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package com.joelhooks.parsley.example.controllers
{
	import com.joelhooks.parsley.example.delegates.FlickrImageServiceDelegate;
	import com.joelhooks.parsley.example.delegates.IGalleryImageServiceDelegate;
	import com.joelhooks.parsley.example.events.GalleryImageServiceEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class RetrieveGalleryAction extends EventDispatcher
	{
		[Inject(id="photoServiceDelegate")]
		public var serviceDelegate:IGalleryImageServiceDelegate;
		
		public function RetrieveGalleryAction(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		[MessageHandler(selector="serviceReady")]
		public function handlePhotoServiceReady(event:GalleryImageServiceEvent):void
		{
			serviceDelegate.loadGallery();
		}
	}
}