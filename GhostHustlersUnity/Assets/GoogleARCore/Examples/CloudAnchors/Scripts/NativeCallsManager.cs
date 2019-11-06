
namespace GoogleARCore.Examples.CloudAnchors
{
    using System.Runtime.InteropServices;

    public class NativeAPI {
    [DllImport("__Internal")]
        public static extern void showHostMainWindow(string lastStringColor);
    }
    public class NativeCallsManager
    {    
        public static void showHostMainWindow()
        {
    #if UNITY_ANDROID
            try
            {
                AndroidJavaClass jc = new AndroidJavaClass("com.company.product.OverrideUnityActivity");
                AndroidJavaObject overrideActivity = jc.GetStatic<AndroidJavaObject>("instance");
                overrideActivity.Call("showMainActivity", lastStringColor);
            } catch(Exception e)
            {
                appendToText("Exception during showHostMainWindow");
                appendToText(e.Message);
            }
    #elif UNITY_IOS
            NativeAPI.showHostMainWindow("a_string");
    #endif
        }
    }


}