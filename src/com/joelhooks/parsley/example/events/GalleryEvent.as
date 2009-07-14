/*
	Inversion of Control/Dependency Injection Using Parsley
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package com.joelhooks.parsley.example.events
{
	import com.joelhooks.parsley.example.models.vo.Gallery;
	
	import flash.events.Event;

	public class GalleryEvent extends Event
	{
		public static const GALLERY_LOADED:String = "galleryLoaded";
		
		public var gallery:Gallery;
		
		public function GalleryEvent(type:String, gallery:Gallery)
		{
			this.gallery = gallery;
			super(type, true, true);
		}
		
		override public function clone() : Event
		{
			return new GalleryEvent(this.type, this.gallery);
		}
	}
}