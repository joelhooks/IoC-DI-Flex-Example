/*
	Inversion of Control/Dependency Injection Using Parsley
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package com.joelhooks.parsley.example.models.presentation
{
	import com.joelhooks.parsley.example.events.GalleryImageEvent;
	import com.joelhooks.parsley.example.models.vo.Gallery;
	import com.joelhooks.parsley.example.models.vo.GalleryImage;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.swizframework.factory.IDispatcherBean;

	[Bindable]
	public class FlickrGalleryPresentationModel extends EventDispatcher implements IGalleryPresentationModel, IDispatcherBean
	{
		private var _gallery:Gallery;
		private var _selectedImage:GalleryImage;
		
		private var _dispatcher:IEventDispatcher;

		public function set dispatcher(v:IEventDispatcher):void
		{
			_dispatcher = v;
		}

		
		public function FlickrGalleryPresentationModel( )
		{

		}
		
		[Bindable( "galleryChanged" )]
		public function get gallery():Gallery
		{
			return this._gallery;
		}
		
		public function set gallery(v:Gallery):void
		{
			this._gallery = v;
			this.dispatchEvent(new Event("galleryChanged"));
			this._dispatcher.dispatchEvent(new GalleryImageEvent(GalleryImageEvent.SELECT_GALLERY_IMAGE, 
				gallery.photos[0] as GalleryImage));
		}
		
		[Bindable( "selectedImageChanged" )]
		public function get selectedImage():GalleryImage
		{
		
			return this._selectedImage;
		}
		
		public function set selectedImage(v:GalleryImage):void
		{
			this._selectedImage = v;
			this.dispatchEvent(new Event("selectedImageChanged"));
		}
	}
}