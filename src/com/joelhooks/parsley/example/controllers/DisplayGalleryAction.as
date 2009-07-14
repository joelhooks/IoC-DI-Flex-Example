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
	import com.joelhooks.parsley.example.events.GalleryEvent;
	import com.joelhooks.parsley.example.events.GalleryImageEvent;
	import com.joelhooks.parsley.example.models.presentation.IGalleryPresentationModel;
	import com.joelhooks.parsley.example.models.vo.GalleryImage;
	
	import flash.events.EventDispatcher;

	[Event(name="selectGalleryImage", type="com.joelhooks.parsley.example.events.GalleryImageEvent")]
	[ManagedEvents("selectGalleryImage")]
	public class DisplayGalleryAction extends EventDispatcher
	{
		[Inject(id="galleryPresentationModel")]
		public var galleryPresentationModel:IGalleryPresentationModel;
		
		public function DisplayGalleryAction()
		{
		}
		
		[MessageHandler(selector="galleryLoaded")]
		public function handleGalleryLoaded(event:GalleryEvent):void
		{
			this.galleryPresentationModel.gallery = event.gallery
			trace(event.gallery.photos.length);
			this.dispatchEvent(new GalleryImageEvent(GalleryImageEvent.SELECT_GALLERY_IMAGE, 
				event.gallery.photos[0] as GalleryImage));
		}
	}
}