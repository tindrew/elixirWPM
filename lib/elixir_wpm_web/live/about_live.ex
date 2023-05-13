defmodule ElixirWPMWeb.AboutLive do
  use ElixirWPMWeb, :live_view
  import Phoenix.LiveView.Helpers

  def mount(_params, _sessions, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class=" w-1/2  border rounded border-slate-500 font-monoid font-bold centered-div py-8 ">
      <p class=" text-1xl text-slate-gray px-2  leading-10">

      This project is meant to be more than just a game. While on its face it has many of the same
      aspects of any other typing game, the idea behind it is providing a resource to emphasize the
      importance of muscle memory in programming and recall of syntax.



      Most programming communities overlook the importance of drilling code to retain basics,
      instead suggesting the use of copy-and-paste. However, this approach hinders beginners'
      ability to recall and solve problems, as they struggle to remember what to type. With this app,
      we hope to help solve this issue for Elixir learners by providing a platform to practice and reinforce
      their coding skills, helping them remember the concepts they may have forgotten while learning,
      while also having a bit of fun!.</p>
    </div>
    """
  end
end
